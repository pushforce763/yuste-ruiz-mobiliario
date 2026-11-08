Add-Type -AssemblyName System.Drawing

function Resize-ToFile($srcPath, $destPath, $w, $h) {
  $src = [System.Drawing.Image]::FromFile($srcPath)
  $dest = New-Object System.Drawing.Bitmap $w, $h
  $dest.SetResolution($src.HorizontalResolution, $src.VerticalResolution)
  $g = [System.Drawing.Graphics]::FromImage($dest)
  $g.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
  $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
  $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $g.DrawImage($src, 0, 0, $w, $h)
  $g.Dispose()
  $dest.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)
  $dest.Dispose()
  $src.Dispose()
}

function Resize-ToSquareCanvas($srcPath, $destPath, $size) {
  $src = [System.Drawing.Image]::FromFile($srcPath)
  $scale = [Math]::Min($size / $src.Width, $size / $src.Height)
  $w = [int]([Math]::Round($src.Width * $scale))
  $h = [int]([Math]::Round($src.Height * $scale))
  $x = [int](($size - $w) / 2)
  $y = [int](($size - $h) / 2)
  $dest = New-Object System.Drawing.Bitmap $size, $size
  $g = [System.Drawing.Graphics]::FromImage($dest)
  $g.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceOver
  $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
  $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $g.Clear([System.Drawing.Color]::Transparent)
  $g.DrawImage($src, $x, $y, $w, $h)
  $g.Dispose()
  $dest.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)
  $dest.Dispose()
  $src.Dispose()
}

$root = "C:\Users\borja\repos\muebles-yuste"
Resize-ToFile "$root\img\logo.png" "$root\img\logo-76.png" 80 76
Resize-ToSquareCanvas "$root\img\logo.png" "$root\img\favicon-32.png" 32
Resize-ToSquareCanvas "$root\img\logo.png" "$root\img\apple-touch-icon.png" 180

Get-ChildItem "$root\img" | Select-Object Name, Length
