require! {
  flightplan: plan
}


plan.target \production,
  host: 'sharock1.pine.moe'
  username: 'sharock'
  agent: process.env.SSH_AUTH_SOCK


plan.remote (remote) ->
  remote.with 'cd ~/project/sharock-deploy/frontend', ->
    remote.log 'Run deploy script'
    remote.exec 'bash deploy.bash'
