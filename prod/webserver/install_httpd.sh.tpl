#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<html>
  <head>
<title>Flowers Webserver</title>
 </head>
 <body>
<center>
    <h1>Created by Gaurav, Rohan, Harsh, Lihini, Dharmik fof Project. </h1>
</center>

<table border="5" bordercolor="grey" align="center">
    <tr>
        <th colspan="3">My Favourite Flowers</th> 
    </tr>
    <tr>
        <th>Spring</th>
        <th>Summer</th>
        <th>Fall</th>
    </tr>
    <tr>
        <td><img src="https://webserver-images-gp.s3.amazonaws.com/daffodil.jpeg" alt="" border=3 height=200 width=300></img></th>
        
    </tr>
    <tr>
        <td>><img src="https://webserver-images-gp.s3.amazonaws.com/tulip.jpeg" alt="" border=3 height=200 width=300></img></th>
      
    </tr>
</table>
  </body>
  <html> " >  /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd