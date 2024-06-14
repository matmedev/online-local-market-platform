workspace {
  !identifiers hierarchical

  model {
    buyer = person "Buyer"
    merchant = person "Merchant"
    pickUpPoint = person "Pick Up Point"
    backofficeAgent = person "Backoffice Agent"

    platform = softwareSystem "Online Local Market Platform" {
      frontend = group "Frontend" {
        commerceWebApp = container "Buyer web app" "Next.js" "Web app for buyers"
        commerceNativeApp = container "Buyer app" "Expo (RN)" "Native app for buyers"
        merchantNativeApp = container "Merchant app" "Expo (RN)" "Native app for merchants"
        pickUpPointNativeApp = container "Pick-up Point app" "Expo (RN)" "Native app for pick-up points"

        backofficeWebApp = container "Backoffice web app" "Next.js" "Web app for backoffice users"
      }

      backend = group "Backend" {
        clientFrontendServer = container "Client BE" "Server-side part of the Next.js web app for all users"
        backofficeFrontendServer = container "BO BE" "Server-side part of the Next.js web app for backoffice users"

        hasura = container "Unified data access" "Hasura for Unified Data Access"

        database = container "DB" "PostgreSQL"

        notificationService = container "Notification Service" "TBD third-party service"

        clientFrontendServer -> hasura "loads data from and writes data to"
        backofficeFrontendServer -> hasura "loads data from and writes data to"

        hasura -> database "persists and queries data to/from"
        hasura -> notificationService "connects requests to"
      }
    }

    buyer -> commerceWebApp "uses"
    buyer -> commerceNativeApp "uses"
    merchant -> merchantNativeApp "uses"
    pickUpPoint -> pickUpPointNativeApp "uses"
    backofficeAgent -> backofficeWebApp "uses"

    commerceWebApp -> clientFrontendServer "loads data from" {
      tags = indirect
    }

    backofficeWebApp -> backofficeFrontendServer "loads data from" {
      tags = indirect
    }

    commerceNativeApp -> clientFrontendServer "loads data from"
    merchantNativeApp -> clientFrontendServer "loads data from"
    pickUpPointNativeApp -> clientFrontendServer "loads data from"

    commerceWebApp -> hasura "subscribe to events from"
    commerceNativeApp -> hasura "subscribe to events from"
    merchantNativeApp -> hasura "subscribe to events from"
    pickUpPointNativeApp -> hasura "subscribe to events from"
  }

  views {
    systemContext platform "Platform" {
      include *
      autolayout lr

    }

    container platform "Generic" {
      include *
      autolayout lr
    }

    styles {
      element "Person" {
        shape person
      }
    }
  }
}
