#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

setup_s3() {
    # List the S3 apps installed on the system
    s3_apps="$(yunohost app list -f --output-as json | jq -r '[ .apps[] | select(.manifest.id == "minio" or .manifest.id == "garage") ]')"
    s3="${s3:-minio}"

    # If there are no S3 app installed
    if [ $(jq -r '[ .[] | select(.manifest.id == "minio" or .manifest.id == "garage").id ] | length' <<< $s3_apps) -eq 0 ]
    then
        ynh_die "The app needs at least one S3 instance (Minio or Garage) to be installed. Install or restore one first."
        # Else if the configured S3 app is not in the list, default to the first one and display a warning
    elif [ $(jq --arg s3 $s3 -r '[ .[] | select(.id == $s3) ] | length' <<< $s3_apps) -ne 1 ]
    then
        s3="$(jq -r 'sort_by(.id) | first.id' <<< $s3_apps)"
        ynh_print_warn "The S3 app was not set up, or the one initially set up for $app has not been found. Reconfiguring with $s3"
        ynh_app_setting_set --key=s3 --value=$s3
    fi

    # Prepare the variables
    s3_domain=$(ynh_app_setting_get --app="$s3" --key=domain)
    s3_local_port=$(ynh_app_setting_get --app="$s3" --key=port)

    ynh_app_setting_set --key="s3_domain" --value="$s3_domain"
    ynh_app_setting_set --key="s3_local_port" --value="$s3_local_port"
}

get_s3_credentials() {
    s3="${s3:-minio}"
    s3_password=$(ynh_string_random -l 32)
    s3_user=$app

    ynh_app_setting_set --key="s3_user" --value="$s3_user"
    ynh_app_setting_set --key="s3_password" --value="$s3_password"
}

get_celery_broker_url() {
    redis_db=$(ynh_app_setting_get --key=redis_db)
    echo "redis://127.0.0.1:6379/$redis_db"
}
