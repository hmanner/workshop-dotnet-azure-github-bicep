    param appId string
    param slotId string
    param location string
    param appName string

    resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' = {
      name: 'kv-${appName}'
      location: location
      properties: {
        tenantId: subscription().tenantId
        sku: {
          family: 'A'
          name: 'standard'
        }
        accessPolicies: [
          // AppService
          {
            tenantId: subscription().tenantId
            objectId: appId
            permissions: {
              keys: [
                'get'
                'list'
                'unwrapKey'
                'wrapKey'
              ]
              secrets: [
                'get'
                'list'
              ]
              certificates: []
            }
          }
          // AppService Slot
          {
            tenantId: subscription().tenantId
            objectId: slotId
            permissions: {
              keys: [
                'get'
                'list'
                'unwrapKey'
                'wrapKey'
              ]
              secrets: [
                'get'
                'list'
              ]
              certificates: []
            }
          }
          // Myself - normally you wouldn't put a user here, you'd use a Group all the developers are in
          {
            tenantId: subscription().tenantId
            objectId: '77061311-148d-4360-8a2e-c31fbbb688c7'
            permissions: {
                keys: [
                    'get'
                    'list'
                    'update'
                    'create'
                    'import'
                    'delete'
                    'recover'
                    'backup'
                    'restore'
                    'decrypt'
                    'encrypt'
                    'unwrapKey'
                    'wrapKey'
                    'verify'
                    'sign'
                    'purge'
                ]
                secrets: [
                    'get'
                    'list'
                    'set'
                    'delete'
                    'recover'
                    'backup'
                    'restore'
                    'purge'
                ]
                certificates: [
                    'get'
                    'list'
                    'update'
                    'create'
                    'import'
                    'delete'
                    'recover'
                    'backup'
                    'restore'
                    'manageContacts'
                    'manageIssuers'
                    'getIssuers'
                    'listIssuers'
                    'setIssuers'
                    'deleteIssuers'
                    'purge'
                ]
            }
          }
        ]
      }
    }

    output keyVaultName string = keyVault.name
