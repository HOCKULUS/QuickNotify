$counter = 0
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(374,126)
$Form.text                       = "Form"
$Form.TopMost                    = $true
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
$Form.Location.X = 123
$Form.Location.y = 123
$Poistion = 'RightBottom'
$Coordinates = switch ($Poistion)
{
    'LeftTop' { 0, 0 }
    'LeftBottom'  { 0, $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Bottom - $Form.Height) }
    'RightTop' { $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - $Form.Width), 0 }
    'RightBottom' { $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - $Form.Width), $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Bottom - $Form.Height) }
}
#$Form.Location = New-Object System.Drawing.Point($Coordinates)
$Form.StartPosition = [System.Windows.Forms.FormStartPosition]::Manual

$Button_ok                       = New-Object system.Windows.Forms.Button
$Button_ok.text                  = "OK"
$Button_ok.Visible               = $false
$Button_ok.width                 = 101
$Button_ok.height                = 30
$Button_ok.location              = New-Object System.Drawing.Point(259,84)
$Button_ok.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',11)
$Button_ok.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#9b9b9b")
$Button_ok.BackColor             = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$PictureBox1                     = New-Object system.Windows.Forms.PictureBox
$PictureBox1.width               = 60
$PictureBox1.height              = 60
$PictureBox1.location            = New-Object System.Drawing.Point(11,16)
$PictureBox1.imageLocation       = "" #Your Image here
$PictureBox1.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Sample Text here" #Your Text here
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(83,21)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',13)
$Label1.ForeColor                = [System.Drawing.ColorTranslator]::FromHtml("#9b9b9b")

$CheckBox1                       = New-Object system.Windows.Forms.CheckBox
$CheckBox1.AutoSize              = $false
$CheckBox1.Visible               = $false
$CheckBox1.width                 = 238
$CheckBox1.height                = 25
$CheckBox1.location              = New-Object System.Drawing.Point(11,96)
$CheckBox1.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$CheckBox1.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#9b9b9b")

$Form.controls.AddRange(@($Button_ok,$PictureBox1,$Label1,$CheckBox1))
$global:a = 1 #if $a is 0 the MasseBox topmost set to false

$Button_ok.Add_Click({
$global:a = 0
while($global:sitze -gt 0){
$global:sitze -= 2 #Animationspeed
$Coordinates = switch ($Poistion)
{ #Screensize
    'LeftTop' { 0, 0 }
    'LeftBottom'  { 0, $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Bottom - $global:sitze + 2 ) }
    'RightTop' { $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - $Form.Width), 0 }
    'RightBottom' { $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - $Form.Width), $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Bottom - $global:sitze +2) }
}
$Form.Location = New-Object System.Drawing.Point($Coordinates) #low slide down
Start-Sleep -Milliseconds 1 #CPU Performace improved
}
[void]$Form.Hide()
})

$Form.Add_MouseHover({
$global:topmost = 1
})
$Form.Add_MouseLeave({
$global:topmost = 0
})
$CheckBox1.Add_MouseHover({
$global:topmost = 1
})
$CheckBox1.Add_MouseLeave({
$global:topmost = 0
})
$Label1.Add_MouseHover({
$global:topmost = 1
})
$Label1.Add_MouseLeave({
$global:topmost = 0
})
$PictureBox1.Add_MouseHover({
$global:topmost = 1
})
$PictureBox1.Add_MouseLeave({
$global:topmost = 0
})
$Button_ok.Add_MouseHover({
$global:topmost = 0
})
$Button_ok.Add_MouseLeave({
$global:topmost = 1
})

#Show Text on Hover
$CheckBox1.Add_MouseHover({ $CheckBox1.text                  = "disable notifications" })
$CheckBox1.Add_MouseLeave({ $CheckBox1.text                  = "" })

#Beta - Save and import settings from a text file
$CheckBox1.add_click({
    if($CheckBox1.Checked -eq $true){
        if(-not(Test-Path ($env:HOMEPATH + "\AppData\Roaming\QickNotify.txt")) -and (Test-Path ($env:HOMEPATH + "\AppData\Roaming\"))){
            new-item -Path ($env:HOMEPATH + "\AppData\Roaming\") -Name "QickNotify.txt" -ItemType "File" -ErrorAction SilentlyContinue
        }
    }
})
#------------------------------------------------

[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')  	 | out-null
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') 	 | out-null
[System.Reflection.Assembly]::LoadWithPartialName('System.Drawing') 		 | out-null
[System.Reflection.Assembly]::LoadWithPartialName('WindowsFormsIntegration') | out-null
$global:i = 0
$time = 2
$icon = [System.Drawing.Icon]::ExtractAssociatedIcon("C:\Windows\System32\Netplwiz.exe") #Your Tray Icon here
$Main_Tool_Icon = New-Object System.Windows.Forms.NotifyIcon #Tray Icon
$Main_Tool_Icon.Text = "QuickNotify - click to Exit" #Popup Text on MouseHover
$Main_Tool_Icon.Icon = $icon
$Main_Tool_Icon.Visible = $true
$Main_Tool_Icon.Add_Click({
$Main_Tool_Icon.Visible = $false
while($global:sitze -gt 0){
$global:sitze -= 2
$Coordinates = switch ($Poistion)
{
    'LeftTop' { 0, 0 }
    'LeftBottom'  { 0, $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Bottom - $global:sitze + 2 ) }
    'RightTop' { $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - $Form.Width), 0 }
    'RightBottom' { $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - $Form.Width), $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Bottom - $global:sitze +2) }
}
$Form.Location = New-Object System.Drawing.Point($Coordinates)
Start-Sleep -Milliseconds 1
}
[void]$Form.Hide()
 })

$global:sitze = 0
[void]$Form.Show()

#While QickNotify Massagebox is visible
#--------------------------------------
#--------------------------------------

do{[System.Windows.Forms.Application]::DoEvents() 
[void]$Form.Update()
Start-Sleep -Milliseconds 1 #Improve CPU Performance
if([System.Windows.Forms.Cursor]::Position.X -gt [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - $Form.Width -and [System.Windows.Forms.Cursor]::Position.Y -gt [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Bottom - $Form.Height -AND $sitze -gt $Form.Height -and $global:a -eq 1){
$CheckBox1.Visible = $true #CheckBox and Button are only visible when the mouse is on the MassageBox
$Button_ok.Visible = $true
if($global:topmost -eq $true){
$Form.TopMost = $true
}
else{
$Form.topmost = $false
}
}
else{
$CheckBox1.Visible = $false
$Button_ok.Visible = $false
$Form.TopMost = $false
}
$counter += 1 #Counter
if(-not($sitze -gt $Form.Height) -and $counter -lt 2000){ #Popup Animation
$global:sitze += 2 #Animationspeed
$Coordinates = switch ($Poistion)
{
    'LeftTop' { 0, 0 }
    'LeftBottom'  { 0, $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Bottom - $global:sitze + 2 ) }
    'RightTop' { $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - $Form.Width), 0 }
    'RightBottom' { $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - $Form.Width), $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Bottom - $global:sitze +2) }
}
$Form.Location = New-Object System.Drawing.Point($Coordinates)
}

if($counter -gt 2000){ #Counter hide the MessageBox if reaches 2000
$global:sitze -= 2 #Animationspeed
$Coordinates = switch ($Poistion)
{ #Get Screensize (WorkingArea = without taskbar)
    'LeftTop' { 0, 0 }
    'LeftBottom'  { 0, $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Bottom - $global:sitze + 2 ) }
    'RightTop' { $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - $Form.Width), 0 }
    'RightBottom' { $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - $Form.Width), $([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Bottom - $global:sitze +2) }
}
$Form.Location = New-Object System.Drawing.Point($Coordinates) #Move the MassageBox to the new Location
if($global:sitze -lt 0){ #Hide the MessageBox if it is not visible in the Working Area
$Form.Visible = $false
}
}
}until($Form.Visible -eq $false)

$Main_Tool_Icon.Visible = $false #Hide Tray Icon if QickNotify Massagebox is not visible
