# Blacklisting IPs Dynamically

Liferay Experience Cloud Self Managed (LXC SM, Previously Liferay DXP Cloud) provides a way to deny IPs by deploying changes to the webserver configuration file. 
This repo provides a way to blacklisting IPs dynamically on the fly by updating an environment variable instead of commiting changes to your repository and creating a deployment.

## How to Deploy

You will need a LXC SM workspace.
Copy the contents of the `prd` folder to the `webserver/configs/{env}` folder in your workspace.
Build and deploy the changes.

Verify the webserver logs, and look for `Running /etc/nginx/scripts/replace_env.sh`

When your site needs to blacklist an IP, go to the Webserver **Environment Variables** page and add the **LCP_DENY_LIST** environment variable with a list of deny IPs separated by ; e.g. **deny 192.168.1.0;deny 192.168.1.2;deny 192.168.1.3;deny 192.168.1.4;**. You may also specify IP ranges e.g. deny 192.168.1.0/24;

Save the change. This will restart the webserver container and access to the webserver URL from any of the blacklisted IPs will be forbidden.

Note: there will be a very small downtime when this happens, but it will not be noticeable with Rolling Updates.

## How it Works

A liferay.conf file is created using the Default liferay.conf supplied in LXC SM. LCP_DENY_LIST text is added inside the location directive.

A startup script replace_env.sh is supplied which checks the **LCP_DENY_LIST** environment variable and replaces the value in liferay.conf. 

After this initial deployment, any time you need to block an IP, simply change the Environment variable to include the new IP in the list.

## Additional Information
This code has been tested in a LXC SM Project with stack version 5.x





