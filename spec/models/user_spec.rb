require 'rails_helper'

  RSpec.describe 'Task management function', type: :model do

    it 'Validation cannot pass if title field is empty' do
        task = Task.new(title: '', content: 'First test', deadline: DateTime.now, status:'pending', priority:'low')
       expect(task).not_to be_valid
    end

    it 'Validation cannot pass if content field is empty' do
        task = Task.new(title: 'sommething', content: '', deadline:DateTime.now+1, status:'started', priority:'high')
        expect(task).not_to be_valid
    end

    it 'If the task title and content are described validation will pass' do
        task = Task.new(title: 'this is', content: 'very good.', deadline: DateTime.now+2, status:'started', priority:'low')
        expect(task).to be_valid
    end

    describe 'You can search with the scope method' do

        before do
          @task1 = FactoryBot.create(:task, title: 'task1', content: 'search with scope 1', deadline:DateTime.now, status:'started', priority:'low')
          @task2 = FactoryBot.create(:task, title: 'task2', content: 'search with scope 2', deadline:DateTime.now, status:'pending', priority:'high')
          @task3 = FactoryBot.create(:task, title: 'task3', content: 'search with scope 3', deadline:DateTime.now, status:'completed', priority:'medium')
        end

        it 'You can search for titles' do
          expect(Task.search_sort('task')).to include(@task1)
        end

        it 'You can search the status' do
          expect(Task.status_sort('pending')).to include(@task2)
        end

        it 'You can search the priority' do
          expect(Task.priority_sort('medium')).to include(@task3)
        end

        it 'You can search for both title and status' do
          expect(Task.search_sort('task').status_sort('completed')).to include(@task3)
        end
      end
end
