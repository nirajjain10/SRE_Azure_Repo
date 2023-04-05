#login to your directory
$RG="bicepRG" 
$subscription="" 
$location="eastus"

az login --only-show-errors -o table --query Dummy
#az account set -s $Subscription

az feature register --namespace Microsoft.ContainerService --name AKS-PrometheusAddonPreview
az provider register --namespace Microsoft.OperationsManagement
az provider register --namespace Microsoft.OperationalInsights

az group create --name $RG --location $location
az sshkey create --name "mySSHKey" --resource-group $RG
$sshkey=az sshkey show --resource-group $RG --name "mySSHKey" --query publicKey

#create monitor workspace, maanged cluster and grafana
#az deployment group create --resource-group $RG --template-file .\AKSPromGrafana.bicep --parameters aksclusterName=sreCluster dnsPrefix=sredns linuxAdminUsername=linuxadmin sshRSAPublicKey=$sshkey
az deployment group create --name "SREDEPLOY" --resource-group $RG --template-file .\AKSPromGrafana.bicep --parameters AKSPromGrafana.parameters.json sshRSAPublicKey=$sshkey

