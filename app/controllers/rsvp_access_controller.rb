class RsvpAccessController < ApplicationController
  def show
    @reunion = Reunion.find(params[:reunion_id])
    @membership = ReunionMembership.find_by_rsvp_token(params[:token])

    raise ActiveRecord::RecordNotFound unless @membership&.reunion_id == @reunion.id
  end
end