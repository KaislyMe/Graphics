#ifndef __CUSTOM_INCLUDE_FILE_HLSL
#define __CUSTOM_INCLUDE_FILE_HLSL

void GetValue_float(float x, out float val)
{
	val = x * _Multiplier;
}

#endif // __CUSTOM_INCLUDE_FILE_HLSL
