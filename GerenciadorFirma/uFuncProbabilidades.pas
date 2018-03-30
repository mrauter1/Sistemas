unit uFuncProbabilidades;

// Source: http://www.adug.org.au/MathsCorner/MathsCornerNDist.htm

interface

uses system.sysutils, math;

function NormalZ (const X: Extended): Extended;
function NormalP (const A: Extended): Single;
function NormalDistP (const Mean, StdDev, AVal: Extended): Single;
function NormalDistQ (const Mean, StdDev, AVal: Extended): Single;
function NormalDistA (const Mean, StdDev, AVal, BVal: Extended): Single;

implementation

function NormalZ (const X: Extended): Extended;
{ Returns Z(X) for the Standard Normal Distribution as defined by
  Abramowitz & Stegun. This is the function that defines the Standard
  Normal Distribution Curve.
  Full Accuracy of FPU }
begin
  Result := Exp (- Sqr (X) / 2.0)/Sqrt (2 * Pi);
end;
           {
However, the Probability that X < some value A, as described in the picture above, involves calculating the Area under the curve - which thus involves Integration:

This gives us a problem as this cannot be easily implemented in Delphi.

Abramowitz & Stegun provides many different Approximations that can be used in particular the following adapted into Delphi:
            }
function NormalP (const A: Extended): Single;
{Returns P(A) for the Standard Normal Distribution as defined by
  Abramowitz & Stegun. This is the Probability that a value is less
  than A, i.e. Area under the curve defined by NormalZ to the left
  of A.
  Only handles values A >= 0 otherwise exception raised.
  Accuracy: Absolute Error < 7.5e-8 }
const
  B1: Extended = 0.319381530;
  B2: Extended = -0.356563782;
  B3: Extended = 1.781477937;
  B4: Extended = -1.821255978;
  B5: Extended = 1.330274429;
var
  T: Extended;
  T2: Extended;
  T4: Extended;
begin
  if (A < 0) then
    raise EMathError.Create ('Value must be Non-Negative')
  else
  begin
    T := 1 / (1 + 0.2316419 * A);
    T2 := Sqr (T);
    T4 := Sqr (T2);
    Result := 1.0 - NormalZ (A) * (B1 * T + B2 * T2
      + B3 * T * T2 + B4 * T4 + B5 * T * T4);
  end;
end;
              {
Whilst it is not overly important to know the Mathematics behind the algorithm, it is important to know that when we use Approximations we need to be aware how accurate they are. As you can see in the above we are getting a guaranteed 7 decimal place accuracy. Thus we return the result as a Single.
Using the Normal Distribution
When we encounter the Normal Distribution it is often as a problem such as:
If the amount people spend per day in a given store is Normally Distributed with a mean of $200 and a Standard Deviation of $25, then what is the probability that a given person will spend at most $250?
Now our above Approximation doesn't reference the Mean or the Standard Deviation. This is because the above all refers to the Standard Normal Distribution which has a Mean of 0 and a Standard Deviation of 1.
We can easily transform any other Normal Distribution Problem into a Standard Normal Distribution problem by using:
This however can result in Negative values, and our above Approximation only works for Non-negatives. We can get around this by using the Symmetry of the graph, resulting in the following routine:
               }
function NormalDistP (const Mean, StdDev, AVal: Extended): Single;
{Returns the Probability of (X < AVal) for a Normal Distribution
  with given Mean and Standard Deviation.
  Standard Deviation must be > 0 or function will result in an
  exception.
  Accuracy: Absolute Error < 7.5e-8 }
var
  Z: Extended;
  Lower: Boolean;
begin
  if (StdDev <= 0) then
    raise EMathError.Create ('Standard Deviation must be positive')
  else
  begin
    Z := (AVal - Mean) / StdDev; // Convert to Standard (z) value
    Lower := Z < 0; // If Negative use Symmetry to calculate
    if Lower then
      Z := (Mean - AVal) / StdDev;
    Result := NormalP (Z); // Access function
    if Lower then // If Negative use Symmetry to calculate
      Result := 1.0 - Result;
  end;
end;
                   {
With the above we could solve the specified problem by simply calling:

    Value := NormalDistP (200, 25, 250);

But what do we do if we want a Probability that the spend at least $300 or perhaps we want the probability that they spend between $150 and $250?
Once again we use the Symmetry of the above Curve and some simple Algebra.
                     }
function NormalDistQ (const Mean, StdDev, AVal: Extended): Single;
{ Returns the Probability of (X > AVal) for a Normal Distribution
  with given Mean and Standard Deviation.
  Standard Deviation must be > 0 or function will result in an
  exception.
  Accuracy: Absolute Error < 7.5e-8 }
begin
  Result := 1 - NormalDistP (Mean, StdDev, Aval);
end;
                   {
Thus the at least $300 problem would be done by simply calling:

    Value := NormalDistQ (200, 25, 300);
                    }

function NormalDistA (const Mean, StdDev, AVal, BVal: Extended): Single;
{ Returns the Probability of (AVal < X < BVal) for a Normal Distribution
  with given Mean and Standard Deviation.
  Standard Deviation must be > 0 or function will result in an
  exception.
  Accuracy: Absolute Error < 7.5e-8 }
begin
  if (AVal = BVal) then
    Result := 0
  else
  begin
    Result := NormalDistP (Mean, StdDev, BVal) -
      NormalDistP (Mean, StdDev, AVal);
    if BVal < AVal then
      Result := -1 * Result;
  end;
end;
                      {
Thus the at between $150 and $250 problem would be done by simply calling:

    Value := NormalDistA (200, 25, 150, 250);

and notice we have constructed it so that the following would give the same result:

    Value := NormalDistA (200, 25, 250, 150);

Conclusion

Next Issue we will continue our look at Normal Distributions.
                       }
end.
