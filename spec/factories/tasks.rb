FactoryBot.define do
  factory :task do
    title { 'title_test' }
    content { 'content test 1' }
    deadline { '2022-03-30 20:00:00' }
    status { 'started' }
    priority { 'low' }
  end

  factory :second_task, class: Task do
    title { 'test 2' }
    content { 'content test 2' }
    deadline { '2022-03-30 20:00:00' }
    status { 'started' }
    priority { 'low' }
  end
end
