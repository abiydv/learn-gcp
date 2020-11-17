# gcloud cli commands used

gcloud projects list
gcloud projects create tools-202011

gcloud config set project tools-202011

gcloud iam service-accounts list
gcloud iam service-accounts create tools-service-account
gcloud projects add-iam-policy-binding tools-202011 --member serviceAccount:tools-service-account@tools-202011.iam.gserviceaccount.com --role roles/storage.admin
gcloud projects add-iam-policy-binding tools-202011 --member serviceAccount:tools-service-account@tools-202011.iam.gserviceaccount.com --role roles/compute.admin

gcloud compute ssh tf-compute-1 --zone us-central1-a
gcloud compute disks list --filter="zone:us-central1-a"
gcloud compute instances list --filter="zone:us-central1-a"

gsutil mb gs://tools-202011
gsutil ls -r gs://tools-202011/*

