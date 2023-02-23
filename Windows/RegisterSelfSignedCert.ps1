# https://amgeneral.wordpress.com/2019/01/03/powershell-download-certificate-chain-from-https-site/
[Net.ServicePointManager]::ServerCertificateValidationCallback = {$true} # disable the verification, ref. https://stackoverflow.com/a/73544386/6201547
$webRequest = [Net.WebRequest]::Create("https://www.google.com")
$webRequest.GetResponse()
$cert = $webRequest.ServicePoint.Certificate
$chain = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Chain
$chain.build($cert)
$chain.ChainElements.Certificate | % {set-content -value $($_.Export([Security.Cryptography.X509Certificates.X509ContentType]::Cert)) -encoding byte -path "root-ca.cer"}

$env:JAVA_HOME\bin\keytool -importcert -noprompt -alias root-ca.cer -cacerts -storepass changeit -file "root-ca.cer"