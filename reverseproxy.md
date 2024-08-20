# Install Apache2
```
sudo apt install apache2
```

# Enable Proxy Modules
```
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_balancer
sudo a2enmod lbmethod_byrequests
```
# Configure Virtual Host (/etc/apache2/sites-available/000-default.conf)
```
<VirtualHost *:80>

    # Add this
    ProxyPass / http://private-ip-backend1/
    ProxyPassReverse / http://private-ip-backend1/

</VirtualHost>
```