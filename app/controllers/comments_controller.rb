# encoding: utf-8
class CommentsController < ApplicationController
  before_filter :login_required
  # plants/id/notes/id/
  def create
    plant = Plant.find(params[:plant_id])
    note = Note.find(params[:note_id])
    comment = Comment.new(:content => params[:content])
    comment.user = current_user
    note.comments << comment
    comment.save
    note.save
    render :partial => '/plants/comment_item', :locals => {:comment_item => comment}
  end
  
  # plants/id/notes/id/comments/id
  def destroy
    plant = Plant.find(params[:plant_id])
    note = Note.find(params[:note_id]) 
    comment = note.comments.find(params[:id])
    comment.destroy
    render :json => {:result => true}
  end
end
