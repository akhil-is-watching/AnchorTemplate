FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.cargo/bin:${PATH}"
ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    git \
    pkg-config \
    libssl-dev \
    libudev-dev \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*


# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN rustup component add rustfmt clippy

# Install Solana CLI
RUN sh -c "$(curl -sSfL https://release.anza.xyz/stable/install)"
RUN export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
RUN echo 'export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"' >> ~/.bashrc

# Install Anchor CLI
RUN cargo install --git https://github.com/coral-xyz/anchor avm --locked --force
RUN avm install latest --force --from-source
RUN avm use latest

RUN solana-keygen new --no-bip39-passphrase

# Set working directory
WORKDIR /usr/src/app

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Command to keep container running
ENTRYPOINT ["/entrypoint.sh"]
