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

  private
  def note_params
    params.require(:note).permit(:content, :user_id, :book_id)
  end
end