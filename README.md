# onprem-azuredevops-docker-agent
# Warning
# Create agent user and set up home directory in dockerfiles
RUN useradd -m -d /home/agent agent
RUN chown -R agent:agent /azp /home/agent

USER agent
# Another option is to run the agent as root.
ENV AGENT_ALLOW_RUNASROOT="true"

docker run -d \
-e AZP_URL="<Azure DevOps instance>" \
-e AZP_TOKEN="<Personal Access Token>" \
-e AZP_POOL="<Agent Pool Name>" \
-e AZP_AGENT_NAME="Docker Agent - Linux" \
--name "azp-agent-linux" \
azp-agent:linux

# docker-agent
Dockerfile
# docker in docker agent
docker-in-docker-agent.dockerfile