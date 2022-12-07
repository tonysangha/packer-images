source "vmware-iso" "windows_10" {
  vm_name             = "win-10"
  winrm_password      = "P@$$w0rd"
  winrm_username      = "acme"
  communicator        = "winrm"
  cpus                = "4"
  disk_size           = "50000"
  disk_adapter_type   = "nvme"
  disk_type_id        = "0"
  memory              = "16384"
  version             = "19"
  floppy_files        = ["./answer-files/Autounattend.xml", 
                          "./scripts/disable-network-discovery.cmd", 
                          "./scripts/fixnetwork.ps1", 
                          "./scripts/microsoftupdates.bat", 
                          "./scripts/win-updates.ps1", 
                          "./scripts/enable-rdp.cmd", 
                          "./scripts/disable-uac.cmd"]
  guest_os_type    = "windows9-64"
  headless         = false
  iso_checksum     = "sha256:7F6538F0EB33C30F0A5CBBF2F39973D4C8DEA0D64F69BD18E406012F17A8234F"
  iso_url          = pathexpand("~/ISO/Win10_21H2_English_x64.iso")
  output_directory = pathexpand("~/Virtual Machines/win-10")
  shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c Packer_Provisioning_Shutdown"
  skip_export      = true
  keep_registered  = true
  skip_compaction  = false
}

build {
  sources = ["source.vmware-iso.windows_10"]

  provisioner "file" {
    destination = "c:\\users\\cloudflare\\downloads\\"
    source = "./files/Cloudflare_CA.crt"
  }

  provisioner "windows-shell" {
    inline = ["certutil.exe -addstore root c:\\users\\cloudflare\\downloads\\Cloudflare_CA.crt"]
  }

  provisioner "windows-shell" {
    execute_command = "{{ .Vars }} cmd /c \"{{ .Path }}\""
    scripts         = ["./scripts/chocolatey.bat"]
  }

  provisioner "powershell" {
    scripts = ["./scripts/install-apps.ps1"]
  }

  provisioner "powershell" {
    scripts = ["./scripts/install_warp.ps1"]
  }

    provisioner "powershell" {
    scripts = ["./scripts/localisation.ps1"]
  }

  provisioner "windows-shell" {
    scripts = ["./scripts/enable-uac.cmd"]
  }
}



