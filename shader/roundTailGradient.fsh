#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform float u_tailLengthPer;

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
const float PI2 = 6.283185308179586;
//2.0*3.141592653589793

//get current radian of the pos.
float getRadianWithPos(vec2 pos)
{
    vec2 offPos = vec2(pos.x - 0.5, pos.y - 0.5);
    float a = abs(pos.x - 0.5);
    float b = abs(pos.y - 0.5);
    float c = sqrt(a*a + b*b);
    float radian = acos(b / c);
    if(offPos.x > 0.0 && offPos.y < 0.0)
    {
        return radian;
    }
    if(offPos.x > 0.0 && offPos.y > 0.0)
    {
        radian = PI2 / 2.0 - radian;
        return radian;
    }
    if(offPos.x < 0.0 && offPos.y > 0.0)
    {
        radian = radian + PI2 / 2.0;
        return radian;
    }
    if(offPos.x < 0.0 && offPos.y < 0.0)
    {
        radian = PI2-radian;
        return radian;
    }

    return radian;
}

//get current radiu of the pos.
float getRadiuWithPos(vec2 pos)
{
    vec2 offPos = vec2(pos.x - 0.5, pos.y - 0.5);
    float r = sqrt(offPos.x*offPos.x + offPos.y*offPos.y);
    return r;
}

void main()
{
    vec4 v_texColor = v_fragmentColor * texture2D(CC_Texture0, v_texCoord);
    vec2 pos = vec2(v_texCoord.x, v_texCoord.y);

    float timePer;
    // for optimized display effect
    // 1. At the head, speed*2.0;
    // 2. Increase the tial length on an overall basis.
    if(u_time < u_tailLengthPer)
    {
        timePer = u_time*2.0;
    }
    else
    {
        timePer = u_time + u_tailLengthPer;
    }

    float radian = getRadianWithPos(pos);
    float r = getRadiuWithPos(pos);
    float alpha = 1.0;
    if( (radian / PI2) < timePer && (radian / PI2) > (timePer - u_tailLengthPer) )
    {
        float offper = timePer - (radian / PI2);
        alpha = (u_tailLengthPer - offper) / (u_tailLengthPer * 1.0);
    }
    if( (radian / PI2) < (timePer - u_tailLengthPer) )
    {
        alpha = 0.0;
    }

    gl_FragColor = v_texColor*alpha;
}
