## External Installation instructions

Greenbot Admin is written in Meteor 1.3. To use it in production, deploy it like any other meteor version. Which I admit, is not super easy.

* Install node verion 0.10.45 on system.  We use a package called 'n' to manage node versions.  Greenbot-core is built on the edge API, currently 6.2. To use node version 0.10.45, install 'npm install -g n', and then set the version of node as 'n 0.10.45'. You can set it back to greenbot-core version with 'n 6.2'
* Install mupx on the system: npm install -g mupx
* In a seperate directory, configure a mup.json file to point to your deployment target: 
    
    {
      // Server authentication info
      "servers": [
        {
          "host": "104.131.xxx.xxx",
          "username": "root",
          //"password": "password",
          // or pem file (ssh based authentication)
          // WARNING: Keys protected by a passphrase are not supported
          "pem": "~/.ssh/id_rsa"
          // Also, for non-standard ssh port use this
          //"sshOptions": { "port" : 49154 },
          // server specific environment variables
        }
      ],
    
      // Install MongoDB on the server. Does not destroy the local MongoDB on future setups
      "setupMongo": true,
    
      // Application name (no spaces).
      "appName": "greenbot-admin",
    
      // Location of app (local directory). This can reference '~' as the users home directory.
      // i.e., "app": "~/Meteor/my-app",
      // This is the same as the line below.
      "app": "~/code/greenbot-admin",
    
      // Configure environment
      // ROOT_URL must be set to your correct domain (https or http)
      "env": {
        "PORT": 80,
        "ROOT_URL": "http://104.131.xx.xxx",
        "GREENBOT_IO_URL":"http://104.131.xx.xxx:3003"
      },
    
      // Meteor Up checks if the app comes online just after the deployment.
      // Before mup checks that, it will wait for the number of seconds configured below.
      "deployCheckWaitTime": 30,
    
      // show a progress bar while uploading.
      // Make it false when you deploy using a CI box.
      "enableUploadProgressBar": true
    }
* mupx setup
* mupx deploy

## Gotcha's
Mupx deploys meteor servers using docker, and _sets the name of the default mongo collection to be the name of the package_. In this case, **greenbot-admin**. The default collection is typically **greenbot**.
