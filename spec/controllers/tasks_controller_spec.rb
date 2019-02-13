require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "returns all tasks for a user" do
      get :index
      expect(assigns(:tasks)).not_to be_nil
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new

      expect(response).to render_template(:new)
    end

    it "assigns a new task to @task" do
      get :new
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe "GET #show" do
    it "assigns the requested task as @task" do
      task = Task.new({name: 'Do homework'})
      task.save
        
      get :show, params: {id: task.to_param}
        
      expect(assigns(:task)).to eq(task)
    end
  end

  describe 'GET #edit' do
    it "assigns the requested task as @task" do
      task = Task.new({name: 'Homework', priority: 2})
      task.save 

      get :edit, params: {id: task.to_param}

      expect(assigns(:task)).to eq(task)
    end

    it "renders the :edit template" do
      task = Task.new({name: 'Homework', priority: 2})
      task.save

      get :edit, params: { id: task.to_param }
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it 'persists new task' do
        pre = Task.all.length
        post :create, params: {task: {priority: 2, name: 'Do Homework'}}
        expect(Task.all.length).to eq(pre+1)
      end
        
      it 'redirects to show page' do
        post :create, params: {task: {priority: 2, name: 'Do Homework'}}
        expect(response).to render_template(:show)
      end
    end

    context 'with invalid attributes' do
      it 'does not persist task' do
        pre = Task.all.length

        post :create, params: {task: {priority: 2}}
        expect(Task.all.length).to eq(pre)
      end

      it 're-renders :new template' do
        post :create, params: {task: {priority: 2}}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it 'updates old task' do
        task = Task.create({name: 'Homework', priority: 2})
        put :update, params: {id: task.id, task: {priority: 4, name: 'Do Homework Now'}}
        expect(Task.find(task.id).name).to eq('Do Homework Now')
      end
        
      it 'redirects to show page' do
        task = Task.create({name: 'Homework', priority: 2})
        put :update, params: {id: task.id, task: {priority: 2, name: 'Do Homework Now'}}
        expect(response).to render_template(:show)
      end
    end

    context 'with invalid attributes' do
      it 'does not update task' do
        task = Task.create({name: 'Homework', priority: 2})
        put :update, params: {id: task.id, task: {priority: 4, name: nil}}
        expect(Task.find(task.id).name).to eq('Homework')
      end

      it 're-renders :edit template' do
        task = Task.create({name: 'Homework', priority: 2})
        put :update, params: {id: task.id, task: {priority: 2, name: nil}}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the task" do
      task = Task.create({name: "Homework", priority: 2})

      delete :destroy, params: {id: task.id}
      expect(Task.find_by(id: task.id)).to be(nil)
    end

    it "redirects to index" do
      task = Task.create({name: "Homework", priority: 2})
      len = Task.all.length

      delete :destroy, params: {id: task.id}
      expect(response).to redirect_to(tasks_path)
    end


  end
end
