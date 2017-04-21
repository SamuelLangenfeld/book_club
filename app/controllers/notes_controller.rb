class NotesController < ApplicationController
  before_action :correct_user?, only: [:update, :destroy]
  before_action :authenticate_user!

  def create
    @note = Note.new(note_params)
    respond_to do |format|
      if @note.save
        format.html { redirect_to Book.find(@note.book_id), notice: 'Note was successfully created.' }
      else
        format.html { render 'static_pages/home' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @note=Note.find(note_params[:id])
    @note.update(note_params)
    flash[:notice]='Note saved'
    redirect_to Book.find(@note.book_id)
  end

  def destroy
    @note=Note.find(note_params[:id])
    @note.destroy
    flash[:notice]='Note deleted'
    redirect_back(fallback_location: root_path)
  end

  private
  def note_params
    params.require(:note).permit(:content, :user_id, :book_id, :id)
  end

  def correct_user?
    unless current_user==User.find(note_params[:user_id])
      redirect_to new_user_session_path
    end
  end

end