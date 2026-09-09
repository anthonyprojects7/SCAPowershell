$wallpaperfolder = "C:\Wallpapers"
$images = get-childitem -path $wallpaperfolder -include *.jpg, *.jpeg, *.png, *.bmp -file

if($images.count -gt 0) {
    $randomimage = get-random -InputObject $images

    $desktop = new-object -comobject shell.application
    $activedesktop = $desktop.gettype().InvokeMember("ActiveDesktop", "GetProperty", $null, $desktop, $null)

    $activedesktop.SetWallpaper($randomimage.fullname, 0)
    $activedesktop.applychanges(0x01)
}

    $animatedfolder = "C:\Wallpapers\Animated"
    $animatedwallpapers = get-childitem -path $animatedfolder -directory 

    if($animatedwallpapers.count -gt 0) {
        $randomanimated = get-random -inputobject $animatedwallpapers
        $weexe = "env:programfiles\steam\steamapps\common\wallpaper_engine\wallpaper64.exe"
        if (test-path $weexe) {
            start-process $weexe -ArgumentList "-control", "openwallpaper", "-file", $randomanimated.fullname
        }
    }

    