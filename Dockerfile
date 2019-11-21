# Dockerfile extending the generic Node image with application files for a
# single application.
#FROM gcr.io/google_appengine/nodejs
#20180704 alpine does not come with apt-get. need to update this file to get it to work
FROM node:10
LABEL name="bot-render" \
  version="0.1" \
  description="Renders a webpage for bot consumption (not production ready)"

RUN apt-get update && apt-get install -y \
  wget \
  --no-install-recommends \
  && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && apt-get update && apt-get install -y \
  google-chrome-stable \
  fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# Check to see if the the version included in the base runtime satisfies
# '>=7.6', if not then do an npm install of the latest available
# version that satisfies it.
#RUN /usr/local/bin/install_node '>=7.6'

ENTRYPOINT [ "node" ]
CMD ["-v"]
