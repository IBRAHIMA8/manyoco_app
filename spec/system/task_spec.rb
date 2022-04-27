require 'rails_helper'
RSpec.describe 'Task management function', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end
  describe 'New creation function' do
    context 'When creating a new task' do
      it 'The created task is displayed' do
        visit new_task_path
      fill_in "Title", with: 'title_test'
      fill_in "Content", with: 'content test'
      fill_in "Deadline", with: '2021/1/1'
      select 'started'
      select 'low'
      click_on 'Create New Task'
      expect(page).to have_content 'title_test'
    end
  end
end

  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'The created task list is displayed' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end

  describe 'Detailed display function' do
     context 'When transitioned to any task details screen' do
       it 'The content of the relevant task is displayed' do
         visit new_task_path
       fill_in "Title", with: 'title_test4'
       fill_in "Content", with: 'content test'
       fill_in "Deadline", with: '2022-04-20 02:09 PM'
       select 'started'
       select 'low'
       click_on 'Create New Task'
       expect(page).to have_content 'title_test4'
       end
     end
  end
describe 'Detailed list in descending order of tasks' do
    context 'When tasks are arranged in descending order of creation date and time' do
      it 'List of tasks sorted in descending order of creation date' do
        visit tasks_path
        click_on 'Sort by Deadline'
        assert Task.all.order('created_at desc')
      end
    end
  end
    context 'When searching with the scope method' do
          it "You can search for titles with the scope method" do
            visit root_path
            fill_in 'search_title', with: 'title_test'
            click_on 'search'
            # expect(Task.get_by_taskname('task').count).to eq 1
            expect(page).to have_content 'title_test'
          end
          it "You can search the status with the scope method" do
            visit root_path
            select 'started', from: 'search_status'
            click_on 'search'
            expect(page).to have_content 'title_test'
          end
          it "You can search the priority with the scope method" do
            visit root_path
            select 'low', from: 'search_priority'
            click_on 'search'
            expect(page).to have_content 'Task'
          end
          it "Both title and status can be searched with the scope method" do
            visit root_path
            fill_in 'search_title', with: 'Task'
            select 'completed', from: 'search_status'
            click_on 'search'
            expect(page).to have_content 'Task'
          end
          it "Both title and priority can be searched with the scope method" do
            visit root_path
            fill_in 'search_title', with: 'Task'
            select 'high', from: 'search_priority'
            click_on 'search'
            expect(page).to have_content 'Task'
          end
          it "Both status and priority can be searched with the scope method" do
            visit root_path
            select 'completed', from: 'search_status'
            select 'low', from: 'search_priority'
            click_on 'search'
            # binding.irb
            expect(page).to have_content 'Task'
          end
        end
  end
