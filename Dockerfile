FROM alpine:3.11

# Install dependencies, Git, and Rust
RUN apk add --no-cache ansible git curl \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && source $HOME/.cargo/env

# Add Rust to PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Install Python packages
RUN pip3 install --upgrade paramiko

# Install Ansible collection
RUN ansible-galaxy collection install cisco.nxos
RUN ansible-galaxy collection install paloaltonetworks.panos

# Set environment variables
ENV ANSIBLE_HOST_KEY_CHECKING=False
