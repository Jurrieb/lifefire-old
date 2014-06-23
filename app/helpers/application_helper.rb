module ApplicationHelper

  # Give correct labels
  def reduced_cigarettes_helper(count_reduced)
    if count_reduced >= 0
      "#{count_reduced} verminderd"
    else
      "#{count_reduced.abs} vermeerderd"
    end
  end
end
