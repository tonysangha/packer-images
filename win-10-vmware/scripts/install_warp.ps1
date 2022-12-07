Invoke-WebRequest -Uri 'https://1.1.1.1/Cloudflare_WARP_Release-x64.msi' -OutFile "c:\Windows\temp\Cloudflare_WARP_Release-x64.msi"

msiexec.exe /qn /norestart /i c:\Windows\temp\Cloudflare_WARP_Release-x64.msi