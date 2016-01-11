require! {
  flightplan: plan
}


plan.target \production,
  host: 'sharock1.pine.moe'
  username: 'sharock'
  agent: process.env.SSH_AUTH_SOCK


plan.remote (remote) ->
  remote.with 'cd ~/project/sharock-frontend', ->
    remote.log 'Update files'
    remote.git 'fetch origin master'
    remote.git 'reset --hard origin/`git rev-parse --abbrev-ref HEAD`'

  remote.with 'cd ~/project/sharock-deploy/frontend', ->
    remote.log 'Run deploy script'
    remote.exec 'bash deploy.bash'
