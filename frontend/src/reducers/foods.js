// foods.jsx で使用するReducer

import { REQUEST_STATE } from "../constants";

// stateの初期値
export const initialState = {
  fetchState: REQUEST_STATE.INITIAL,
  foodsList: []
};

// パターン分けするための文字列
export const foodsActionTypes = {
  FETCHING: 'FETCHING',
  FETCH_SUCCESS: 'FETCH_SUCCESS'
};

// Reducer関数
export const foodsReducer = (state, action) => {
  switch (action.type) {
    case foodsActionTypes.FETCHING:
      return {
        ...state,
        fetchState: REQUEST_STATE.LOADING
      };
    case foodsActionTypes.FETCH_SUCCESS:
      return {
        fetchState: REQUEST_STATE.OK,
        foodsList: action.payload.foods
      };

    default:
      throw new Error();
  }
}