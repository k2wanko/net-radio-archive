class OnsenProgram < ActiveRecord::Base
  STATE = {
    waiting: 'waiting',
    downloading: 'downloading',
    done: 'done',
    failed: 'failed',
  }
end
