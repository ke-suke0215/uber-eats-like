import React, { Fragment, useEffect } from 'react';

// api
import { fetchFoods } from '../apis/foods';

export const Foods = ({ match }) => {
  useEffect(() => {
    fetchFoods(match.params.restaurantsId)
      .then((data) => console.log(data))
  }, [])

  console.log(match)
  return (
    <Fragment>
      フード一覧
      <p>
        restaurantsIDは {match.params.restaurantsId} です
      </p>
    </Fragment>
  )
}