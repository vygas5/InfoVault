class VaultEntriesController < ApplicationController
  before_action :set_entry, only: %i[ show edit update destroy ]

  def index
    @entries = Current.user.vault_entries.order(updated_at: :desc)
  end

  def show
  end

  def new
    @entry = Current.user.vault_entries.build(kind: params[:kind] || "note")
  end

  def create
    @entry = Current.user.vault_entries.build(entry_params)
    if @entry.save
      redirect_to @entry, notice: "Saved."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @entry.update(entry_params)
      redirect_to @entry, notice: "Updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @entry.destroy
    redirect_to vault_entries_path, notice: "Deleted.", status: :see_other
  end

  private

  def set_entry
    @entry = Current.user.vault_entries.find(params[:id])
  end

  def entry_params
    params.require(:vault_entry).permit(:title, :body, :kind)
  end
end
