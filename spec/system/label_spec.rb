require 'rails_helper'
RSpec.describe 'Label test',type: :system do
    describe 'While testing Label functions' do
        before do
          @user = FactoryBot.create(:user, name: 'exemple', email: 'exemple@gmail.com', password: '123456789')
          @task = FactoryBot.create(:task)
          @task2 = FactoryBot.create(:second_task)
          @task3 = FactoryBot.create(:third_task)
          label = Label.create(name:'AA',user_id:nil,id: 1)
          labeling = FactoryBot.create(:labeling1)
          visit new_session_path
          fill_in 'session[email]', with: 'exemple@gmail.com'
          fill_in 'session[password]', with: '123456789'
          click_button 'Sign in'
        end
        context 'Create new task' do
          it 'Labels are displayed' do
            visit new_session_path
            expect(page).to have_content 'AA'
          end
          it 'create new task and add tag' do
            visit new_task_path
            fill_in 'task[title]', with: 'new one task'
            fill_in 'task[content]', with: 'new one task content'
            #find(:css, "#task_label_ids_1").set(true)
            check 'AA'
            #sleep 5
            click_on 'Create New Task'
            expect(page).to have_content 'new one task'
          end
          it 'You can search by label' do
             visit tasks_path
             select 'AA',from: 'search_label'
             click_on 'search'
             expect(page).to have_content 'AA'
          end
        end
      end
end
