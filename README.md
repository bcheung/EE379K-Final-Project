# Pod Security Policies Demo

## Setup

### Install Docker and Microk8s
    sudo apt install docker.io
    sudo snap install microk8s --classic

### Microk8s Setup
    microk8s.enable registry dns

## Procedure

### Without Pod Security Policies

Build Docker images, tag and push to local registry, apply deployments and services to K8s cluster

    make all

Escalate privileges to root in non-root-debian pod

    microk8s.kubectl exec -it [non-root-debian pod name] bash
    su root
    password

Delete deployments and services

    make delete

#### Results
- Both pods run
- Escalation of privileges allowed in non-root-debian pod

### With Pod Security Policies

Enable Pod Security Policies by adding the following line to the /var/snap/microk8s/current/args/kube-apiserver file

    --enable-admission-plugins=PodSecurityPolicy

Restart microk8s.daemon-apiserver

    sudo systemctl restart snap.microk8s.daemon-apiserver

Create and apply restrictive Pod Security Policy for the cluster

    microk8s.kubectl apply -f policy/psp-restrictive.yaml
    microk8s.kubectl get psp
    NAME              PRIV    CAPS   SELINUX    RUNASUSER          FSGROUP     SUPGROUP    READONLYROOTFS   VOLUMES
    psp-restrictive   false          RunAsAny   MustRunAsNonRoot   MustRunAs   MustRunAs   false            configMap,emptyDir,projected,secret,downwardAPI,persistentVolumeClaim

Apply deployments and services to K8s cluster

    make apply

Escalate privileges to root in non-root-debian pod

    microk8s.kubectl exec -it [non-root-debian pod name] bash
    su root
    password

Delete deployments and services

    make delete

#### Results

- Root-debian pod has a CreateContainerConfigError
- Non-root-debian pod runs but does not allow privilege escalation



