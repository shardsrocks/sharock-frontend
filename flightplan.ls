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
    remote.git 'reset --hard HEAD'
    remote.git 'fetch origin master'
    remote.git 'checkout master'
    remote.git 'rebase origin/master'

    remote.log 'Install dependencies'
    remote.npm 'install'
