import styled from "styled-components";
import { FONT_SIZE } from "../../style_constants";
import { BaseButton } from "../shared_style";

export const OrderButton = styled(BaseButton)`
  width: 390px;
  background-color: black;
  color: white;
  border-style: none;
  padding: 8px 16px;
  font-size: ${FONT_SIZE.BODY1};
`;