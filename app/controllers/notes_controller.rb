class NotesController < ApplicationController
  before_filter :login_required
  # plants/id/notes/id
  def show
    note = Note.find(params[:id])
    comments = note.comments.order_by(:updated_at.desc)
    render :partial => '/plants/comment_item', :collection => comments
  end
  
  # plants/id/notes
  def create
    plant = Plant.find(params[:plant_id])
    if Note.where(:plant_id => plant._id, :user_id => current_user._id).blank?
      note = Note.new
      note.note = params[:content]
      note.plant = plant
      note.user = current_user
      note.save
      render :partial => '/plants/note_item', :locals => {:note_item => note}
    else
      render :text => 1
    end
  end
  
  # plants/id/notes/id
  def update
    plant = Plant.find(params[:plant_id])
    note = Note.find(params[:id])
    note.note = params[:content]
    note.save
    render :json => {:result => true}
  end
  
  # plants/id/notes/id
  def destroy
    plant = Plant.find(params[:plant_id])
    note = Note.find(params[:id])
    note.destroy
    render :json => {:result => true}
  end
end
