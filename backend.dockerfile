# Use Node.js Alpine image
FROM node:20.18.0-alpine

# Arguments for API and WebSocket URLs
ARG NEXT_PUBLIC_WS_URL=ws://127.0.0.1:3001
ARG NEXT_PUBLIC_API_URL=http://127.0.0.1:3001/api

# Set environment variables
ENV NEXT_PUBLIC_WS_URL=${NEXT_PUBLIC_WS_URL}
ENV NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL}


# Install Python and dependencies (needed for running test.py)
RUN apk update && apk add python3 py3-pip

# Set working directory in the container
WORKDIR /home/perplexica

# Copy the application files (UI and Python script)
COPY ui /home/perplexica/

# If the Python script is located elsewhere, make sure it's copied too
# COPY test.py /home/perplexica/

# Install Node.js dependencies and build the project
RUN yarn install --frozen-lockfile
RUN yarn build

# Run the Python script (test.py)
RUN python3 test.py

# Start the app with Yarn
CMD ["yarn", "start"]
