FROM ubuntu:22.04

RUN apt update && apt install -y iputils-ping

# Install Terraform
RUN apt update && apt install -y vim curl wget gpg lsb-release netcat
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt update && apt -y install terraform

RUN echo "alias tfi='terraform init'" >> ~/.bashrc && \
    echo "alias tfa='terraform apply'" >> ~/.bashrc && \
    echo "alias tfaa='terraform apply -auto-approve'" >> ~/.bashrc && \
    echo "alias tfaav='terraform apply -auto-approve -var-file=\"params.tfvars\"'" >> ~/.bashrc && \
    echo "alias tfd='terraform destroy'" >> ~/.bashrc && \
    echo "alias tfda='terraform destroy -auto-approve'" >> ~/.bashrc && \
    echo "alias tfdav='terraform destroy -auto-approve -var-file=\"params.tfvars\"'" >> ~/.bashrc


# Install Docker CLI
RUN apt update && apt install ca-certificates curl
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc
RUN echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && apt install -y docker-ce-cli


# Install KinD
RUN [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-amd64
RUN chmod +x ./kind
RUN mv ./kind /usr/local/bin/kind


# Install kubectl
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
RUN chmod 644 /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && apt-get install -y kubectl


## Install helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh


# Clone mxd repo
#RUN mkdir /tractus-x
#RUN cd /tractus-x && git clone https://github.com/eclipse-tractusx/tutorial-resources.git

WORKDIR /project

CMD sleep infinity