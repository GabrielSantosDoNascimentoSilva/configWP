#!/bin/bash
clear
echo “Configuration WP”
echo “Set up name  site”
read opc
wp option update blogname $opc
