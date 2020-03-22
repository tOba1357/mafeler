class DashboardController < ApplicationController
  def index
    from = Date.parse(params[:from])
    to = Date.parse(params[:to])
    data = {
        from: from,
        to: to,
        sleeps: summary_sleeps(fitbit_account, from, to),
        activities: summary_activities(fitbit_account, from, to),
        diaries: current_user.diaries.where('date between ? and ?', from, to).as_json(include: [:user_defined_item_values]),
        heart_rates: fitbit_account.present? ? fitbit_account.fitbit_heart_rates.where('date between ? and ?', from, to) : [],
        # nature_remo: nature_remo.present? ? nature_remo.as_json(include: [:humidities, :illuminations, :temperatures]) : nil,
        health_planet: {
            innerscans: health_planet.present? ? health_planet.innerscans.where('datetime between ? and ?', from, to).order(:datetime) : []
        }
    }
    render json: data
  end


  private
  def fitbit_account
    current_user.fitbit_account
  end

  def nature_remo
    current_user.nature_remo
  end

  def summary_sleeps(fitbit_account, from, to)
    return [] if fitbit_account.blank?
    sql = <<-SQL
      with _sleeps as (
        select
          date,
          EXTRACT(epoch from end_time - start_time) sec,
          efficiency
        from fitbit_sleeps
        where fitbit_account_id = :id
          and date between :from and :to
      ) select
        date,
        sum(sec) as sec,
        sum(sec * efficiency) / sum(sec) as efficiency
      from _sleeps
      group by date;
    SQL
    SqlExecuteService.select_all sql, {id: fitbit_account.id, from: from, to: to}
  end

  def summary_activities(fitbit_account, from, to)
    return [] if fitbit_account.blank?
    sql = <<-SQL
      select
        cast(start_time as date) date,
        sum(duration) duration
      from fitbit_activities
      where fitbit_account_id = :id
        and start_time between :from and :to
      group by cast(start_time as date);
    SQL
    SqlExecuteService.select_all sql, {id: fitbit_account.id, from: from, to: to}
  end
end
