﻿using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

$APIName = $TriggerMetadata.FunctionName
Write-LogMessage -user $request.headers.'x-ms-client-principal' -API $APINAME -message 'Accessed this API' -Sev 'Debug'

$Table = Get-CIPPTable -TableName SchedulerConfig
$Filter = "RowKey eq 'CippNotifications' and PartitionKey eq 'CippNotifications'"
$Config = Get-AzDataTableEntity @Table -Filter $Filter

$body = $Config

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = [HttpStatusCode]::OK
        Body       = $body
    })
