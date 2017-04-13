class NotesController < ApplicationController
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
    if correct_user?(@note)
      @note.destroy
      flash[:notice]='Note deleted'
      redirect_to :back
    end
  end

  private
  def note_params
    params.require(:note).permit(:content, :user_id, :book_id, :id)
  end

  def correct_user?(note)
    current_user==User.find(note.user_id)
  end

end