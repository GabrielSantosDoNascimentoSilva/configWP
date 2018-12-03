#!/bin/bash
clear
echo “Configuration WP”
echo “Set up name  site”
read opc
wp option update blogname $opc

wp config set WP_DEBUG true
wp option update blogname "NOME DO SITE"
wp option update blogdescription "SLOGAN DO SITE"
wp option update blog_public 0

wp rewrite structure /%postname%/
wp option update admin_email sitebemfeito@gmail.com
wp user create USUÁRIO LOGIN --role=administrator 
wp plugin install really-simple-ssl wp-fastest-cache 
wp plugin install cresta-whatsapp-chat maintenance loco-translate duplicate-post simple-facebook-plugin gtranslate updraftplus popup-maker contact-form-7 masks-form-fields wordpress-importer --activate
wp theme delete twentyfourteen
wp theme delete twentyfifteen
wp theme delete twentysixteen
wp theme delete twentyseventeen
