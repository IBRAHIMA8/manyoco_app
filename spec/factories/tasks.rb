FactoryBot.define do
  factory :task ,class: Task do
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
  factory :third_task, class: Task do
    title { 'test 3' }
    content { 'content test 3' }
    deadline { '2022-03-30 20:00:00' }
    status { 'completed' }
    priority { 'high' }
end
end
