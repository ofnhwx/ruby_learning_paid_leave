# frozen_string_literal: true

require 'date'
require './models/user'
require './models/paid_leave'
require './models/paid_leave_application'

# 社員数 n
n = gets.to_i

# 社員情報の取得
users = []
n.times do
  input = gets.chomp!.split(' ', 2)
  id = input[0].to_i
  name = input[1]
  users << User.new(id, name)
end

# クエリの行数 m, 開始日
input = gets.split
m = input[0].to_i
base_date = Date.parse(input[1])

# 社員毎に有給休暇の管理を行う
paid_leave_application_map = {}
users.each do |user|
  paid_leave_application_map[user.id] = PaidLeaveApplication.new(base_date)
end

# 有給休暇の申請数分処理を回す
m.times do
  input = gets.split
  id = input[0].to_i
  date = Date.parse(input[1])
  puts paid_leave_application_map[id].application(date)
  puts paid_leave_application_map
end

