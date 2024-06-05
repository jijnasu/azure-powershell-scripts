New-AzResourceGroup -Name jijpwc-sourceRG -Location centralus


# Create first web app in Central US region.

$webapp1 = New-AzWebApp -Name "jijpwc-WebAppContoso-01" -Location centralus -ResourceGroupName jijpwc-sourceRG -AppServicePlan myAppServicePlanCentralUS

# Create second web app in South Central US region.

$webapp2 = New-AzWebApp -Name "jijpwc-WebAppContoso-02" -Location EastUS -ResourceGroupName jijpwc-sourceRG -AppServicePlan myAppServicePlanEastUS


#Create the profile

$fdprofile = New-AzFrontDoorCdnProfile -ResourceGroupName jijpwc-sourceRG -Name contosoAFD -SkuName Premium_AzureFrontDoor -Location Global



#Create the endpoint

$FDendpoint = New-AzFrontDoorCdnEndpoint -EndpointName contosofrontend -ProfileName contosoAFD -ResourceGroupName jijpwc-sourceRG -Location Global


# Create health probe settings

$HealthProbeSetting = New-AzFrontDoorCdnOriginGroupHealthProbeSettingObject -ProbeIntervalInSecond 60 -ProbePath "/" -ProbeRequestType GET -ProbeProtocol Http

# Create load balancing settings

$LoadBalancingSetting = New-AzFrontDoorCdnOriginGroupLoadBalancingSettingObject -AdditionalLatencyInMillisecond 50 -SampleSize 4 -SuccessfulSamplesRequired 3

# Create origin group

$originpool = New-AzFrontDoorCdnOriginGroup -OriginGroupName og -ProfileName contosoAFD -ResourceGroupName jijpwc-sourceRG -HealthProbeSetting $HealthProbeSetting -LoadBalancingSetting $LoadBalancingSetting


# Add first web app origin to origin group.

$origin1 = New-AzFrontDoorCdnOrigin -OriginGroupName og -OriginName contoso1 -ProfileName contosoAFD -ResourceGroupName jijpwc-sourceRG -HostName jijpwc-WebAppContoso-01.azurewebsites.net -OriginHostHeader jijpwc-WebAppContoso-01.azurewebsites.net -HttpPort 80 -HttpsPort 443 -Priority 1 -Weight 1000

# Add second web app origin to origin group.

$origin2 = New-AzFrontDoorCdnOrigin -OriginGroupName og -OriginName contoso2 -ProfileName contosoAFD -ResourceGroupName jijpwc-sourceRG -HostName jijpwc-WebAppContoso-02.azurewebsites.net -OriginHostHeader jijpwc-WebAppContoso-02.azurewebsites.net -HttpPort 80 -HttpsPort 443 -Priority 1 -Weight 1000


# Create a route to map the endpoint to the origin group

$Route = New-AzFrontDoorCdnRoute -EndpointName contosofrontend -Name defaultroute -ProfileName contosoAFD -ResourceGroupName jijpwc-sourceRG -ForwardingProtocol MatchRequest -HttpsRedirect Enabled -LinkToDefaultDomain Enabled -OriginGroupId $originpool.Id -SupportedProtocol Http,Https


$fd = Get-AzFrontDoorCdnEndpoint -EndpointName contosofrontend -ProfileName contosoafd -ResourceGroupName jijpwc-sourceRG

$fd.hostname


# Stop-AzWebApp -ResourceGroupName jijpwc-sourceRG -Name "jijpwc-WebAppContoso-01"


# Start-AzWebApp -ResourceGroupName jijpwc-sourceRG -Name "jijpwc-WebAppContoso-01"