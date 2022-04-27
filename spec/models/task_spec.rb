require 'rails_helper'
RSpec.describe Task, type: :model do
#  pending "add some examples to (or delete) #{__FILE__}"
  describe 'Task model function', type: :model do
    describe 'Validation test' do
      context "If the task Title is empty" do
        it "It's hard to Validation" do
          task = Task.new(title: '', content: 'Failure test', deadline: DateTime.now, status: 'started', priority: 'low')
          expect(task).not_to be_valid
        end
      end
      context 'If the task Title and details are described' do
        it 'Validation passes' do
          task = Task.new(title: 'Title3', content: 'COCOCOCOCOS', deadline: DateTime.now, status: 'started', priority: 'low')
          expect(task).to be_valid # Write content here
        end
      end
      context "If the task details are empty" do
            it 'Validation is caught' do
              task = Task.new(title: 'Title3', content: '', deadline: DateTime.now, status: 'started', priority: 'low')
              expect(task).not_to be_valid # Write content here
        end
      end
      describe 'You can search with the scope method' do
      before do
        @task = FactoryBot.create(:task, title: 'task',content: 'something', deadline:DateTime.now,status:0,priority:1)
        @second_task = FactoryBot.create(:second_task, title: 'second_task',content: 'something1', deadline:DateTime.now,status:1,priority:0)
        @third_task = FactoryBot.create(:third_task, title: 'third_task',content: 'something2', deadline:DateTime.now,status:2,priority:1)
      end
      it 'You can search for titles' do
        expect(Task.search_sort('task')).to include(@task)
      end
      it 'You can search the status' do
        expect(Task.status_sort(1)).to include(@second_task)
      end
      it 'You can search the priority' do
        expect(Task.priority_sort(1)).to include(@third_task)
      end
      it 'You can search for both title and status' do
        expect(Task.search_sort('third_task').status_sort(2)).to include(@third_task)
      end
    end
    end
  end

end
